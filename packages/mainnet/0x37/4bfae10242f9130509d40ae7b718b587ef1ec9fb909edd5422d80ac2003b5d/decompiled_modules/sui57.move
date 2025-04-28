module 0x374bfae10242f9130509d40ae7b718b587ef1ec9fb909edd5422d80ac2003b5d::sui57 {
    struct SUI57 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI57, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI57>(arg0, 9, b"SUI57", b"Sui-57", b"The Suikhoi Sui-57  is a twin-engine meme, ZenG-generation stealth multirole Memecraft developed by the Sui Ecosystem. It's designed for crypto community superiority and deadly meme missions, boasting sui development, humour, and building sui dominance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/04cd2cec8a13adcaae8ac97340873f36blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI57>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI57>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

