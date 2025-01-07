module 0x7c280df6d0f3ac11561fc292c0518acad2ec31edc318d675bd8e8eeb2232a36a::farm {
    struct FARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARM>(arg0, 6, b"FARM", b"Sui Farmer", b"SUI FARMER is the ultimate degen token on Sui, fueling a high-APY farming platform to stack gains and ape into the next-gen DeFi ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733533102462.10")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

