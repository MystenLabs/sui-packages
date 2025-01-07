module 0xbff8dc60d3f714f678cd4490ff08cabbea95d308c6de47a150c79cc875e0c7c6::sbox {
    struct SBOX has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: SBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOX>(arg0, 1, b"SBOX", b"SuiBoxer Coin", b"SUI said fuck off but we say welcome, airdrop for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pntvpw2m7uxvx7j4roojxy3sb2lrc57jqzwo66kafwdjaj5v3oea.arweave.net/e2dX20z9L1v9PIucm-NyDpcRd-mGbO95QC2GkCe124g")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOX>>(v2);
        0x2::coin::mint_and_transfer<SBOX>(&mut v3, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SBOX>>(v3);
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<SBOX>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<SBOX>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

