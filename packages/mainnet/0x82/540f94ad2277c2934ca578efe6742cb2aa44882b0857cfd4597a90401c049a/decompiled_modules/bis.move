module 0x82540f94ad2277c2934ca578efe6742cb2aa44882b0857cfd4597a90401c049a::bis {
    struct BIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIS>(arg0, 6, b"BIS", b"BitSui", b"BitSui is an innovative digital currency that blends the stability and reputation of Bitcoin with the advanced technology and ultra-fast infrastructure offered by Sui. This currency brings together the best of both worlds, making it an ideal choice for both investors and users alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_20_at_2_06_57_PM_a92fa00fb6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

