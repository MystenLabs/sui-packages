module 0xee13f7e784dea867688a0a29fc176b2279e645532af8ea4e812b89f374d7c12e::job {
    struct JOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOB>(arg0, 9, b"JOB", b"Jean On Blast", b"Jean still here and watch blastfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/a/AdXWn7D")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JOB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

