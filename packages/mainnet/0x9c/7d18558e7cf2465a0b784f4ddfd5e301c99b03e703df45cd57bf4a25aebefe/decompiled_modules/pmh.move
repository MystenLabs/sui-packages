module 0x9c7d18558e7cf2465a0b784f4ddfd5e301c99b03e703df45cd57bf4a25aebefe::pmh {
    struct PMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMH>(arg0, 9, b"PMH", b"PMH coin", b"PMH is a digital token built on blockchain technology. It is designed to offer fast, secure, and low-cost transactions, making it easy and accessible for everyday use.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPDzMJv6veu8FwVatUxw9JeAsZJa8XgsU75i6q9pyatey")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PMH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMH>>(v1);
    }

    // decompiled from Move bytecode v6
}

