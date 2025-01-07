module 0xc12036a1e7e187be41492376aa3a0277e05efb9fda867917332474ee2488bd9f::pou {
    struct POU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POU>(arg0, 6, b"POU", b"Suipou", b"Suipou is a memecoin on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/236x/86/56/7a/86567a45caa5186f3d9fdaa407e6e086.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POU>>(v1);
    }

    // decompiled from Move bytecode v6
}

