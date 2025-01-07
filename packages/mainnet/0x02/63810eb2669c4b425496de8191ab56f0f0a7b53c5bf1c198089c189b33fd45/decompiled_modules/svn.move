module 0x263810eb2669c4b425496de8191ab56f0f0a7b53c5bf1c198089c189b33fd45::svn {
    struct SVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVN>(arg0, 6, b"SVN", b"SuiVision", b"An Owl called Sui watches over the blockchain and uses it's spiritual energy to protect it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/800104766_fe1ce985a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

