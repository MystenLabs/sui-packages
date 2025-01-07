module 0x11e5adae6fd485672b70691aa71215f08cc16c837aff756469f55a7cc85fe1d2::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 9, b"WIF", b"Moo Deng Wif Hat", b"Moo Deng Wif Hat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmbxKSRm96WJSbQ5VjLB6fdXEBPBaswEuVSGyQS4tho6nj"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIF>>(v1);
        0x2::coin::mint_and_transfer<WIF>(&mut v2, 1000000000000000000, @0x591d022baa8dd6959ae6106f921a1cdd1e404ef715dd5f26f84548f2eb76ba4a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIF>>(v2);
    }

    // decompiled from Move bytecode v6
}

