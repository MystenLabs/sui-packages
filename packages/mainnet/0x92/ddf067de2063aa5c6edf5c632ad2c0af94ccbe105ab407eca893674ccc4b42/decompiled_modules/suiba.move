module 0x92ddf067de2063aa5c6edf5c632ad2c0af94ccbe105ab407eca893674ccc4b42::suiba {
    struct SUIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBA>(arg0, 6, b"SUIBA", b"Suiba Inu", b"The Water Shiba Inu is an ancient elemental guardian born from the purest ocean currents. Its body is made of enchanted, ever-flowing water, and its tail controls the tides. Summoned during times of drought, it restores life to barren lands and maintains the balance between sea and land. Sailors and fishermen regard it as a blessing, as it can calm storms and guide them to safety. Revered as a symbol of nature's harmony, the Water Shiba Inu protects those who respect the natural world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiba_Innu_63721f4c6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

