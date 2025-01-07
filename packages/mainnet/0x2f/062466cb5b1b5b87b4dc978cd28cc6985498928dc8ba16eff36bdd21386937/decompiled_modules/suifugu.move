module 0x2f062466cb5b1b5b87b4dc978cd28cc6985498928dc8ba16eff36bdd21386937::suifugu {
    struct SUIFUGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUGU>(arg0, 9, b"SUIFUGU", b"Sui Fugu", b"The more you HODL, the puffier your portfolio gets. And rumor has it, when the tide's just right, Fugu airdrops a blow-out surprise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/bafybeigla3tkq55v6zonl4w7re44llxait4jt5vr5x4sg7m4mt46kpwwqu"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFUGU>>(v1);
        0x2::coin::mint_and_transfer<SUIFUGU>(&mut v2, 1000000000000000000, @0x31e05b4348c3510f13f33ecf4fca09345eec7658f904f65362c7b9f08c62f603, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIFUGU>>(v2);
    }

    // decompiled from Move bytecode v6
}

