module 0xa0db68ad187eff9f7e56a16cc01d1e50b45dbd307abbf58f1088120c7b3ff298::cia {
    struct CIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIA>(arg0, 6, b"CIA", b"CATS IN ATLANTIS", b"The secret of sui has been revealed along with Atlantis come join the CIA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiah6p3isz254kvexeta3vuzz3msaiskif3qhvv6hzz2ikkmcyy3ea")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

