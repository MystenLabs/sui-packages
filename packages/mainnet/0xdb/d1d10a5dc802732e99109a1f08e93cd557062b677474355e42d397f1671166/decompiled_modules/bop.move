module 0xdbd1d10a5dc802732e99109a1f08e93cd557062b677474355e42d397f1671166::bop {
    struct BOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOP>(arg0, 6, b"BOP", b"Point of Balitze", b"Received many dms about charitys  donation, support and sponsorship from crypto enthusiast based on Balltze, while we are not involved in any crypto, please directly send your support to your local shelters! The donation can be under your name, Balltze or Pochita, names are not", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/retg_a3_O_400x400_c457d28457.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

