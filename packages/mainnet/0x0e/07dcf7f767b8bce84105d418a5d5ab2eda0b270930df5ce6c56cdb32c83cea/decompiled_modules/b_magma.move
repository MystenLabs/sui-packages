module 0xe07dcf7f767b8bce84105d418a5d5ab2eda0b270930df5ce6c56cdb32c83cea::b_magma {
    struct B_MAGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MAGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MAGMA>(arg0, 9, b"bMAGMA", b"bToken MAGMA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MAGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MAGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

