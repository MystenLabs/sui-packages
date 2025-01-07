module 0xb7ca337b53fc056a478fab652e0a0c54f0d56e23a730d90d19deeb7e15b54d61::ics {
    struct ICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICS>(arg0, 6, b"ICS", b"Ice Cream Sandwich", b"Ice Cream Sandwich Comics, created by Andy, is a webcomic and YouTube channel known for its playful humor and charmingly simple art style. The comics often explore relatable everyday scenarios, awkward moments, and random, whimsical thoughts, all depicted through a lovable marshmallow-like character. With a mix of animated videos and static comics, Ice Cream Sandwich captures audiences of all ages, delivering laughter and smiles through its fun and quirky perspective on lif", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049237_21db8e415f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

