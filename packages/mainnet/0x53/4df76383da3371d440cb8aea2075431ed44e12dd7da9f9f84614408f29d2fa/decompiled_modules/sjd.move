module 0x534df76383da3371d440cb8aea2075431ed44e12dd7da9f9f84614408f29d2fa::sjd {
    struct SJD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJD>(arg0, 9, b"SJD", b"Sui Jak Daughter", b"Sui Jak Daughter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/bafybeigwavvemf4b5etgc7q2thwo6jdhcc5dbghsqcay4jfen3uhpxuxni"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJD>>(v1);
        0x2::coin::mint_and_transfer<SJD>(&mut v2, 1000000000000000000, @0xd5de1dc06127efc9b926f75458bcbd401252c8972c865027f5bc972bc2114df0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SJD>>(v2);
    }

    // decompiled from Move bytecode v6
}

