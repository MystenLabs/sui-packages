module 0x855567b01531c38f000d2a308452e57ea130b123e0988d251499f4adf9fe146b::cash {
    struct CASH has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CASH>, arg1: 0x2::coin::Coin<CASH>) {
        0x2::coin::burn<CASH>(arg0, arg1);
    }

    fun init(arg0: CASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASH>(arg0, 6, b"CASH", b"TRUMP CASH", x"43454c4542524154494e472054484520323530746820414e4e4956455253415259204f4620414d45524943412120c2a9434f505952494748545320414e442054524144454d41524b5320323032362d3230393620414c4c2050524f5045525459204f4620442e4a2e542e204e4f542046494e414e4349414c20414456494345202d2055534520415420594f5552204f574e205249534b2e204920414d204e4f54204c4941424c4520464f5220414e59204c4f53532e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicohsjbl24otymuro6dhmvzkcjjnqeazasqmyweapo35cssxn5krq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CASH>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CASH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CASH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

