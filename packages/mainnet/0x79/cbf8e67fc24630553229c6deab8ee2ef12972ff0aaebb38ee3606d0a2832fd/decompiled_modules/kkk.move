module 0x79cbf8e67fc24630553229c6deab8ee2ef12972ff0aaebb38ee3606d0a2832fd::kkk {
    struct KKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKK>(arg0, 6, b"KKK", b"kkk", b"kkkkkkkkkkkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/s-HPKg5HDkO1fqPhE50pYS53sKYZaVuXke49Wa3wzOU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KKK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKK>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

