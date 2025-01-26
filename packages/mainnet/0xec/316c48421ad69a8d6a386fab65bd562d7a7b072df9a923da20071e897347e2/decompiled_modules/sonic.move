module 0xec316c48421ad69a8d6a386fab65bd562d7a7b072df9a923da20071e897347e2::sonic {
    struct SONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONIC>(arg0, 6, b"Sonic", b"26 Jan Sonic", b"Nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/06db6970-dc03-11ef-a403-694c756e712a")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONIC>>(v1);
        0x2::coin::mint_and_transfer<SONIC>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONIC>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

