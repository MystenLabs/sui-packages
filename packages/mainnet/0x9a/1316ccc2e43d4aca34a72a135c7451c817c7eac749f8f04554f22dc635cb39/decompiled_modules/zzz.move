module 0x9a1316ccc2e43d4aca34a72a135c7451c817c7eac749f8f04554f22dc635cb39::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZ>(arg0, 6, b"ZZZ", b"When you finally find the crypto project that let you sleep all night", b"zzzzzzzzzz - When you finally find the crypto project that let you sleep all night", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_19_00_55_08_A_humorous_meme_featuring_a_black_Labrador_dog_sleeping_soundly_with_a_dreamy_whimsical_background_of_floating_clouds_and_soft_moonlight_The_dog_app_c7a2328c10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

