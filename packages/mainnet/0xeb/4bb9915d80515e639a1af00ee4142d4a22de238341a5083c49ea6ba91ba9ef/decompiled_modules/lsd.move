module 0xeb4bb9915d80515e639a1af00ee4142d4a22de238341a5083c49ea6ba91ba9ef::lsd {
    struct LSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSD>(arg0, 9, b"LSD", b"Liquid SUI Derivative 42069", b"$LSD is a revolutionary blockchain cryptography token revolutionizing the realm of digital assets and scientific exploration on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DDti34vnkrCehR8fih6dTGpPuc3w8tL4XQ4QLQhc3xPa.png?size=xl&key=8093b5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LSD>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

