module 0x7e964a6d248669b3c2f70e9929b1d241be5a211dda2ee6285d3f46f649be43a5::ggrn {
    struct GGRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGRN>(arg0, 9, b"GGRN", b"GigaGreen", x"45636f2d636f6e7363696f75732063727970746f20666f7220612062657474657220706c616e65742e205374616b6520746f20737570706f7274207265666f726573746174696f6e2c2072656e657761626c6520656e657267792c20616e6420677265656e20746563682e20546865206d6f7265204747524e20796f7520686f6c642c2074686520636c65616e657220796f7572206469676974616c20666f6f747072696e74206265636f6d65732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/884d98404fee4cfa45d6e2ee95b0803eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGRN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGRN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

