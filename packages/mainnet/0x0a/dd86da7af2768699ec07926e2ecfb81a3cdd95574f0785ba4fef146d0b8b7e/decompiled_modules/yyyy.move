module 0xadd86da7af2768699ec07926e2ecfb81a3cdd95574f0785ba4fef146d0b8b7e::yyyy {
    struct YYYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YYYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YYYY>(arg0, 9, b"yyy", b"yyyy", b"love yyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://amaranth-worthy-crocodile-444.mypinata.cloud/ipfs/bafybeicwrj4rv23h7dfcow3j5tsk6o4zkslosjil3hjb2dwig3knzehl3y")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YYYY>(&mut v2, 2222000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYYY>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YYYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

