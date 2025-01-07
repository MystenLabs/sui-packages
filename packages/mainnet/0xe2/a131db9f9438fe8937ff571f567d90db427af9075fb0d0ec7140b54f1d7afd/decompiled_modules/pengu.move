module 0xe2a131db9f9438fe8937ff571f567d90db427af9075fb0d0ec7140b54f1d7afd::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 9, b"PENGU", b"Pengu Penguins", x"50454e475520495320434f4d494e4720544f2053554921210a0a4c46472120544845204c4f56454c592050454e47552121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2eJAkrBeJwSM1dJLsGCpBYDjMXyPsfUzAuMPeVCyof25.png?size=xl&key=e200f6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENGU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

