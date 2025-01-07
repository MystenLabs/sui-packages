module 0xf0050e9e19019d44b70b956f4978e602dee1923f1f7d732c53736cfb7e4a9c48::vun {
    struct VUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUN>(arg0, 6, b"VUN", b"VUNDIO XYZ", b"Vundio Xyz is specialized NFT Collections designed specifically for enjoyable gaming experiences and usability. Built on SUI Ecosystem.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_26_23_16_48_e0a1094f62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

