module 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty {
    struct Difficulty has copy, drop, store {
        name: 0x1::string::String,
        options: u8,
        correct: u8,
        multiples: vector<u32>,
    }

    public fun difficulties() : vector<Difficulty> {
        let v0 = 0x1::vector::empty<Difficulty>();
        let v1 = &mut v0;
        0x1::vector::push_back<Difficulty>(v1, new(b"easy", 4, 3, vector[126, 159, 201, 254, 321, 406, 514, 651, 824]));
        0x1::vector::push_back<Difficulty>(v1, new(b"medium", 3, 2, vector[142, 202, 287, 408, 581, 827, 1178, 1678, 2391]));
        0x1::vector::push_back<Difficulty>(v1, new(b"hard", 2, 1, vector[190, 361, 685, 1301, 2471, 4694, 8918, 16944, 32193]));
        0x1::vector::push_back<Difficulty>(v1, new(b"extreme", 3, 1, vector[285, 812, 2314, 6594, 18792, 53557]));
        0x1::vector::push_back<Difficulty>(v1, new(b"nightmare", 4, 1, vector[380, 1444, 5487, 20850, 79230, 301074]));
        v0
    }

    public fun new(arg0: vector<u8>, arg1: u8, arg2: u8, arg3: vector<u32>) : Difficulty {
        Difficulty{
            name      : 0x1::string::utf8(arg0),
            options   : arg1,
            correct   : arg2,
            multiples : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

