module 0x6907fa64e7c3af8a4743e3bb94042b83b54f363d6ae7126f6604923b72ffaf78::catalorian {
    struct CATALORIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATALORIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATALORIAN>(arg0, 9, b"CATALORIAN", b"Catalorian", b"The First CATALORIAN Launched on the Ethereum Blockchain right after Elon Musk's Tweet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x8baf5d75cae25c7df6d1e0d26c52d19ee848301a.png?size=xl&key=a459db")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATALORIAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATALORIAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATALORIAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

