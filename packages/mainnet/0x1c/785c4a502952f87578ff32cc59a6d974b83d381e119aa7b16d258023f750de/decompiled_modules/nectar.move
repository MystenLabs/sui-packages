module 0x1c785c4a502952f87578ff32cc59a6d974b83d381e119aa7b16d258023f750de::nectar {
    struct NECTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NECTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NECTAR>(arg0, 8, b"NECTAR", b"NECTAR", b"Nectar tokens are sent by one Wild Channel to another", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmSYXwedon2EKATGTme3963xzKQ2rHXiHtmFDVbp6xLU9C"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NECTAR>(&mut v2, 12000000000000000000, @0x3616157c1dc21217f8ee18513128b4cac25df212505f4ba2b78a5ac9b5a42aae, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NECTAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NECTAR>>(v2, @0x3616157c1dc21217f8ee18513128b4cac25df212505f4ba2b78a5ac9b5a42aae);
    }

    // decompiled from Move bytecode v6
}

