module 0x67582fa73cac40636c9ac75f62824baaaa056663ccd1d2c9d488ce7c3f89415e::emoji {
    struct Emoji has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        style: vector<0x1::string::String>,
        url: 0x1::string::String,
    }

    struct EmojiMinted has copy, drop {
        emoji_id: 0x2::object::ID,
        minted_by: address,
    }

    public fun add_trait(arg0: &mut Emoji, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.style, arg1);
    }

    public fun destroy(arg0: Emoji) {
        let Emoji {
            id    : v0,
            name  : _,
            style : _,
            url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun mint(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = EmojiMinted{
            emoji_id  : 0x2::object::uid_to_inner(&v0),
            minted_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EmojiMinted>(v1);
        let v2 = Emoji{
            id    : v0,
            name  : arg0,
            style : arg1,
            url   : arg2,
        };
        0x2::transfer::transfer<Emoji>(v2, arg3);
    }

    public fun name(arg0: &Emoji) : 0x1::string::String {
        arg0.name
    }

    public fun set_url(arg0: &mut Emoji, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun style(arg0: &Emoji) : &vector<0x1::string::String> {
        &arg0.style
    }

    public fun url(arg0: &Emoji) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

