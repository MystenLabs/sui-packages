module 0xba7a1f357fbf9699fd1431ee62fd4426346159d7782287739955a11b4a7ab9a5::bigsota {
    struct BIGSOTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGSOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGSOTA>(arg0, 6, b"BIGSOTA", b"BIG STICK OF THE ANCIENTS", x"546865206d6967687479206c6567656e6461727920746f6f6c2c20686f6c64696e672074686520706f77657220746f206368616e6765207265616c6974792e0a4869747320686172642e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_12_01_50_45_A_comic_style_illustration_of_an_ancient_wooden_stick_with_a_simple_and_powerful_design_The_stick_appears_weathered_yet_emanates_a_magical_powerful_069d07441e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGSOTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGSOTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

