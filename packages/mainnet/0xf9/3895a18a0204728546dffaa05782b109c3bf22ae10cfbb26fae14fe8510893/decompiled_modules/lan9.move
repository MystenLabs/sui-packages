module 0xf93895a18a0204728546dffaa05782b109c3bf22ae10cfbb26fae14fe8510893::lan9 {
    struct LAN9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN9>(arg0, 9, b"LAN9", b"LAN009", b"009", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVC0B-DXHDAwj4G-cugeASLDoh-JVXsKKXQQ&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAN9>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN9>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAN9>>(v2);
    }

    // decompiled from Move bytecode v6
}

