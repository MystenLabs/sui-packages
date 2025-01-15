module 0x5a84aa0906af88af4d5d1281841b8943162ae8668cc3d068c39807a7f130cb72::penguins {
    struct PENGUINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUINS>(arg0, 6, b"Penguins", b"Penguins", b"Penguins !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn11.bigcommerce.com/s-u0v3cvo4an/images/stencil/598x336/products/16248/34186/big_icon__66853.1601797171.png?c=1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGUINS>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENGUINS>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUINS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

