module 0xb96c3762adca0d306fd0418d49e993d32d5040197c9c11c24f9b5fc019ed090b::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HIPPO>, arg1: 0x2::coin::Coin<HIPPO>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<HIPPO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HIPPO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HIPPO>>(0x2::coin::mint<HIPPO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<HIPPO>(arg0, 9, b"HIPPO", b"HIPPO", x"484950504f2028737564656e672920e2809420746865206c6567656e6461727920686970706f206d656d6520636f696e206f6e205375692e204d6f6f20746f20746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x8993129d72e733985f7f1a00396cbd055bad6f817fee36576ce483c8bbb8b87b%3A%3Asudeng%3A%3Asudeng.png?size=lg&key=f898a6")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<HIPPO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HIPPO>>(v0);
    }

    // decompiled from Move bytecode v6
}

