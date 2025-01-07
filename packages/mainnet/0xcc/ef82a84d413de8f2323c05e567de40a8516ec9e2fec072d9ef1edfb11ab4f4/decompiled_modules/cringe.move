module 0xccef82a84d413de8f2323c05e567de40a8516ec9e2fec072d9ef1edfb11ab4f4::cringe {
    struct CRINGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRINGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRINGE>(arg0, 9, b"CRINGE", b"CRINGE", b"CRINGE CRINGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/LoLLZBUGyTPNWyFF48KbcmkZGc1ajwaFdWoLhF2nBfQ.png?size=xl&key=4316cb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRINGE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRINGE>>(v2, @0xb1ce2eb5717b6b998e10aaddcf44410eb273969bffd2530f400b0b4d5b686054);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRINGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

