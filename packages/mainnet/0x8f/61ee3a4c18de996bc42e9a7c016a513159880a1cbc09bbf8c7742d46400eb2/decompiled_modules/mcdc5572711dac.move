module 0x8f61ee3a4c18de996bc42e9a7c016a513159880a1cbc09bbf8c7742d46400eb2::mcdc5572711dac {
    struct MCDC5572711DAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCDC5572711DAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCDC5572711DAC>(arg0, 9, b"test", b"Test", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-coin-launchpad.preview.emergentagent.com/api/files/suipump/logos/0x9a04278869e706fc3ade67acd74c59f9413d3ba505a456ca60ea23ec92ca6692/17e7a9a1-86c6-41f4-b23c-4c535cf1a924.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MCDC5572711DAC>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCDC5572711DAC>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

