module 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::tagged_output {
    struct TaggedOutput has drop {
        tag: vector<u8>,
        named_payload: 0x2::vec_map::VecMap<vector<u8>, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData>,
    }

    public fun into_parts(arg0: TaggedOutput) : (vector<u8>, 0x2::vec_map::VecMap<vector<u8>, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData>) {
        let TaggedOutput {
            tag           : v0,
            named_payload : v1,
        } = arg0;
        (v0, v1)
    }

    public fun new(arg0: vector<u8>) : TaggedOutput {
        TaggedOutput{
            tag           : arg0,
            named_payload : 0x2::vec_map::empty<vector<u8>, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData>(),
        }
    }

    public fun with_named_payload(arg0: TaggedOutput, arg1: vector<u8>, arg2: 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData) : TaggedOutput {
        0x2::vec_map::insert<vector<u8>, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData>(&mut arg0.named_payload, arg1, arg2);
        arg0
    }

    // decompiled from Move bytecode v6
}

