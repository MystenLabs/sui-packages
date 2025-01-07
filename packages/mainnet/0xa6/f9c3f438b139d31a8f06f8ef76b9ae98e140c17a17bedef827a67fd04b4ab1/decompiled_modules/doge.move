module 0xa6f9c3f438b139d31a8f06f8ef76b9ae98e140c17a17bedef827a67fd04b4ab1::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 9, b"DOGE", b"DOGE COIN", b"Dogecoin is a cryptocurrency that was created in 2013 as a humorous take on Bitcoin. It features the image of a Shiba Inu dog as its logo and mascot. Initially, it was used primarily for tipping and small transactions on social media platforms such as Reddit and Twitter. However, over time it has gained a significant following, with some considering it a legitimate investment vehicle. Dogecoin has a much higher supply than Bitcoin, with over 130 billion coins in circulation as of 2021. Its value is known for being highly volatile and subject to sudden increases and decreases. Despite this, it has gained widespread popularity, with famous individuals such as Elon Musk tweeting about it and even sponsoring a NASCAR driver with Dogecoin branding.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://twitter.com/")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGE>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

