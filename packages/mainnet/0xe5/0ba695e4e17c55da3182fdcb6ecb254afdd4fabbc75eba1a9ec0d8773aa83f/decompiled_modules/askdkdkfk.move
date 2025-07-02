module 0xe50ba695e4e17c55da3182fdcb6ecb254afdd4fabbc75eba1a9ec0d8773aa83f::askdkdkfk {
    struct ASKDKDKFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASKDKDKFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASKDKDKFK>(arg0, 6, b"Askdkdkfk", b"Sjdjfjfj", b"Sndjdjf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigc3d4zajfmlsss45j6n6uhdjyuduydfreglixs3ofy553p2gteaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASKDKDKFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASKDKDKFK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

