module 0x157107b70e8af7b107ebb22afda3031b6157aab10f05460b90e6048d8ab3c093::vnd {
    struct VND has drop {
        dummy_field: bool,
    }

    fun init(arg0: VND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VND>(arg0, 6, b"VND", b"VUNDIO", b"VUNDIO is specialized NFT Collections designed specifically for enjoyable gaming experiences and usability. Built on SUI Ecosystem.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_01_4808b74bef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VND>>(v1);
    }

    // decompiled from Move bytecode v6
}

