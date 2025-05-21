module 0x75dd0ddb49cfee9fb5d147f410c1a4add6ed47c75347f726b945545b642df7bd::wetcoin {
    struct WETCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETCOIN>(arg0, 9, b"wetcoin", b"wetcoin", b"$wetcoin - the moist technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://green-tremendous-starfish-75.mypinata.cloud/ipfs/bafkreidevouczkcfmw46lrmeqee3ram7h6kyn2l3mlv7wybqaknqtztebe")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<WETCOIN>>(0x2::coin::mint<WETCOIN>(&mut v2, 1000000000000000000, arg1), @0x2ba757c3a139bc667e16d8a8f0155fe24d666be8d9dcdb143178d0399c015999);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WETCOIN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WETCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

