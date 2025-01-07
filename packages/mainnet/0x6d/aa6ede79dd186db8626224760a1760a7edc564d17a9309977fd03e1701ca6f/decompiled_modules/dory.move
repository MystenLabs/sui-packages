module 0x6daa6ede79dd186db8626224760a1760a7edc564d17a9309977fd03e1701ca6f::dory {
    struct DORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORY>(arg0, 6, b"DORY", b"Dory On Sui", b"PEPE'S best friend on SUI. One of cryptos most significant cultural icons and the mascot of SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nc4u_HA_11_400x400_6808341748.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

