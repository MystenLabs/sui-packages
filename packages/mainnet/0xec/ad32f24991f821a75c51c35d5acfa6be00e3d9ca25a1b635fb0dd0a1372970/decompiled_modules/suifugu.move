module 0xecad32f24991f821a75c51c35d5acfa6be00e3d9ca25a1b635fb0dd0a1372970::suifugu {
    struct SUIFUGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUGU>(arg0, 9, b"SUIFUGU", b"Sui Fugu", b"The more you HODL, the puffier your portfolio gets. And rumor has it, when the tide's just right, Fugu airdrops a blow-out surprise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/bafybeigla3tkq55v6zonl4w7re44llxait4jt5vr5x4sg7m4mt46kpwwqu"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFUGU>>(v1);
        0x2::coin::mint_and_transfer<SUIFUGU>(&mut v2, 1000000000000000000, @0xa89ff9bd02b3b54676d0458ebfca185b0ad61eb95a75df658e4b4ab78bd6a609, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIFUGU>>(v2);
    }

    // decompiled from Move bytecode v6
}

