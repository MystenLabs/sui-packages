module 0x1de0c64bd1ea655dea73585b13e07dc93bb125849e63c4e966568cde8779267e::snorlaxsui {
    struct SNORLAXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNORLAXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNORLAXSUI>(arg0, 9, b"SNOSUI", b"Snorlaxsui", b"A massive, sleepy critter using a pile of Sui coin pillows, Sui logos drifting above its head like Zzz's.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/TO_BE_UPDATED")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNORLAXSUI>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNORLAXSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNORLAXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

