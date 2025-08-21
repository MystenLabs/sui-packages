module 0x86d8d78bba609473d760dcf41bde4ea4656ac39f9ff2b38cbb349f61e5f4f046::pogi {
    struct POGI has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"$POGI", b"Kapogian", b"It's built on a simple, yet powerful, Filipino principle: everyone is Pogi (handsome, good-looking) in their own unique way. Our mission is to dismantle the narrow definitions of attractiveness and empower a global brotherhood of men to recognize, embrace, and project their own inner Pogi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iamtzar.com/wp-content/uploads/2025/08/kapogian.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: POGI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<POGI>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POGI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<POGI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

