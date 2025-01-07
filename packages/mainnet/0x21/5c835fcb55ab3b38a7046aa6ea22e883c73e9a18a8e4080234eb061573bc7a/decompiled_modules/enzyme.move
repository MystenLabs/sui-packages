module 0x215c835fcb55ab3b38a7046aa6ea22e883c73e9a18a8e4080234eb061573bc7a::enzyme {
    struct ENZYME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENZYME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENZYME>(arg0, 6, b"ENZYME", b"Enzyme", x"496e74726f647563696e6720456e7a796d65202824454e5a594d45292c20746865206d656d6520636f696e207468617420636174616c797a65732074686520667574757265206f662063727970746f20776974682074686520656e65726779206f6620612062696f6c6f676963616c20627265616b7468726f7567682120496e7370697265642062792074686520706f776572206f6620656e7a796d657320696e2062696f6c6f67792c20746869732070726f6a65637420616363656c6572617465732074686520667573696f6e206f6620746563686e6f6c6f677920616e6420636f6d6d756e6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735481322103.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENZYME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENZYME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

