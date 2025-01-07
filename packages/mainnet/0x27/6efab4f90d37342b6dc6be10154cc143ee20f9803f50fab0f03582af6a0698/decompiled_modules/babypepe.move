module 0x276efab4f90d37342b6dc6be10154cc143ee20f9803f50fab0f03582af6a0698::babypepe {
    struct BABYPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPEPE>(arg0, 6, b"BABYPEPE", b"MINI PEPE", b"Pepe reincarnated? Say No More. Pepe is at 3.5B, Mini Pepe is here to take over from Pepe! Mini Pepe is here to take the crypto space by storm, be a part of the revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_20_24_36_a723919db2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

