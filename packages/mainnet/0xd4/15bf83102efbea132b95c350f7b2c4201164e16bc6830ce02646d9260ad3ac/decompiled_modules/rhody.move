module 0xd415bf83102efbea132b95c350f7b2c4201164e16bc6830ce02646d9260ad3ac::rhody {
    struct RHODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHODY>(arg0, 6, b"RHODY", b"RHODYSUI", b"Strong, energetic, and community-driven. Meet RHODY the Rhino on his Web3 adventure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lgi_Qwu49_400x400_112b530e92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHODY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHODY>>(v1);
    }

    // decompiled from Move bytecode v6
}

