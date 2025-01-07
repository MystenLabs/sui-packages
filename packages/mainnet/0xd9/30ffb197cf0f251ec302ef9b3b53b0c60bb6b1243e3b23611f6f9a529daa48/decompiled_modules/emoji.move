module 0xd930ffb197cf0f251ec302ef9b3b53b0c60bb6b1243e3b23611f6f9a529daa48::emoji {
    struct Emoji has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        styles: vector<0x1::string::String>,
        url: 0x1::string::String,
    }

    struct EmojiMinted has copy, drop {
        emoji_id: 0x2::object::ID,
        minted_by: address,
    }

    public fun transfer(arg0: Emoji, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Emoji>(arg0, arg1);
    }

    public fun add_style(arg0: &mut Emoji, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.styles, arg1);
    }

    public fun destroy(arg0: Emoji) {
        let Emoji {
            id     : v0,
            name   : _,
            styles : _,
            url    : _,
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
            id     : v0,
            name   : arg0,
            styles : arg1,
            url    : arg2,
        };
        0x2::transfer::transfer<Emoji>(v2, arg3);
    }

    public fun name(arg0: &Emoji) : 0x1::string::String {
        arg0.name
    }

    public fun set_url(arg0: &mut Emoji, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun styles(arg0: &Emoji) : &vector<0x1::string::String> {
        &arg0.styles
    }

    public fun url(arg0: &Emoji) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

