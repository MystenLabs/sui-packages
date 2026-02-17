module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::parser {
    struct Parser {
        pos0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>,
    }

    public(friend) fun destroy_empty(arg0: Parser) {
        let Parser { pos0: v0 } = arg0;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
    }

    public(friend) fun take_bytes(arg0: &mut Parser, arg1: u64) : vector<u8> {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut arg0.pos0, arg1)
    }

    public(friend) fun take_u16_be(arg0: &mut Parser) : u16 {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut arg0.pos0)
    }

    public(friend) fun take_u64_be(arg0: &mut Parser) : u64 {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut arg0.pos0)
    }

    public(friend) fun take_u8(arg0: &mut Parser) : u8 {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut arg0.pos0)
    }

    public(friend) fun new(arg0: vector<u8>) : Parser {
        Parser{pos0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0)}
    }

    public(friend) fun take_rest(arg0: Parser) : vector<u8> {
        let Parser { pos0: v0 } = arg0;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0)
    }

    // decompiled from Move bytecode v6
}

