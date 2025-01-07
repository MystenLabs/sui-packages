module 0x3908fa577016ea7651e3f85b768a0e1bd48e0df0770d07c584cbccc36208c76b::sht {
    struct SHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHT>(arg0, 6, b"SHT", b"SHUIT", b"The shuitest meme on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_0617a03dc6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

