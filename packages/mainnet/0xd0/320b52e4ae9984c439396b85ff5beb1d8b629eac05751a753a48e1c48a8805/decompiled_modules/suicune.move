module 0xd0320b52e4ae9984c439396b85ff5beb1d8b629eac05751a753a48e1c48a8805::suicune {
    struct SUICUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUNE>(arg0, 6, b"Suicune", b"SUIcune", b"The legendary dog, water-type, memecoin. $Suicune embodies the compassion of pure spring water that runs across the land purifying losses from other memecoins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731360354247.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICUNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

