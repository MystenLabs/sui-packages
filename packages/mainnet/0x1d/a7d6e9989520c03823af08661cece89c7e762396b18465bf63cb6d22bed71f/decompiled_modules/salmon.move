module 0x1da7d6e9989520c03823af08661cece89c7e762396b18465bf63cb6d22bed71f::salmon {
    struct SALMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMON>(arg0, 6, b"SALMON", b"Salmon on Sui", b"The meme coin that swims against the crypto current. Just like the resilient salmon, we're here to break through the noise of the market and make waves on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_02_01_36_56_A_realistic_salmon_logo_design_The_salmon_should_be_sleek_and_detailed_showcasing_its_natural_silver_and_pink_hues_It_should_have_a_dynamic_and_gra_438c4afeb5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

