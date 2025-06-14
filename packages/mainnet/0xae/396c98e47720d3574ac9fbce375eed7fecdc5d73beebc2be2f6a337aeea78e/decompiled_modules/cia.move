module 0xae396c98e47720d3574ac9fbce375eed7fecdc5d73beebc2be2f6a337aeea78e::cia {
    struct CIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIA>(arg0, 6, b"CIA", b"Cats In Atlantis", b"The secret of sui has been revealed along with Atlantis come join the CIA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiah6p3isz254kvexeta3vuzz3msaiskif3qhvv6hzz2ikkmcyy3ea")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

