module 0x2799dee8965ed684dbd12026ad9f7491dd8d01fbf96c26cf4f989ad5a411ab89::suiparrot {
    struct SUIPARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPARROT>(arg0, 6, b"SuiParrot", b"Parrot Sui", b"meme on Sui | loading...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_at_19_59_18_e016acf010.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPARROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPARROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

