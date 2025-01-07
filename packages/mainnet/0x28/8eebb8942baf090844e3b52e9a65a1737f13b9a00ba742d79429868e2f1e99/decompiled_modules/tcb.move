module 0x288eebb8942baf090844e3b52e9a65a1737f13b9a00ba742d79429868e2f1e99::tcb {
    struct TCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCB>(arg0, 9, b"TCB", b"Treecarbon", b"treecarbon TCB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/1sjSnTVtBEZty3TZtDTMcRRlNF5vcNUKc/view?usp=drivesdk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TCB>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

