module 0x290d682044959c577cf5e6cf7ecf15668199db67c2c07bf0dcbc5b42143e03f2::bidon {
    struct BIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIDON>(arg0, 9, b"BIDON", b"Persident bidon", b"Meme president of US of Memerica", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d8f4af2b6a74f911c4d277178993e6b8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIDON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIDON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

