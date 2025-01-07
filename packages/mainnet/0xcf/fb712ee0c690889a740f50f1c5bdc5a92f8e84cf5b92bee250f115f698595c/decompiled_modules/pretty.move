module 0xcffb712ee0c690889a740f50f1c5bdc5a92f8e84cf5b92bee250f115f698595c::pretty {
    struct PRETTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRETTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRETTY>(arg0, 6, b"Pretty", b"Pretty on Sui", b"Pretty Sui launched on movepump   X : @prettyonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsfsf_5da6e35a32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRETTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRETTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

