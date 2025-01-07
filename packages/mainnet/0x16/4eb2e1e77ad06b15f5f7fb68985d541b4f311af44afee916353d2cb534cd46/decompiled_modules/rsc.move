module 0x164eb2e1e77ad06b15f5f7fb68985d541b4f311af44afee916353d2cb534cd46::rsc {
    struct RSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSC>(arg0, 8, b"RSC", b"Runestone", b"Runestone is an open source, transparent, volunteer, and decentralized initiative to reward people who participated in the first year of the Ordinals Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RSC>(&mut v2, 200000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

