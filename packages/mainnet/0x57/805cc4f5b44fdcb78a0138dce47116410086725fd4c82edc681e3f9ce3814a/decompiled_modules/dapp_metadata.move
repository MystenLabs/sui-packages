module 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::dapp_metadata {
    struct DappMetadata has copy, drop, store {
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        icon_url: 0x1::ascii::String,
        website_url: 0x1::ascii::String,
        created_at: u64,
        partners: vector<0x1::ascii::String>,
    }

    public fun get_created_at(arg0: DappMetadata) : u64 {
        arg0.created_at
    }

    public fun get_description(arg0: DappMetadata) : 0x1::ascii::String {
        arg0.description
    }

    public fun get_icon_url(arg0: DappMetadata) : 0x1::ascii::String {
        arg0.icon_url
    }

    public fun get_name(arg0: DappMetadata) : 0x1::ascii::String {
        arg0.name
    }

    public fun get_partners(arg0: DappMetadata) : vector<0x1::ascii::String> {
        arg0.partners
    }

    public fun get_website_url(arg0: DappMetadata) : 0x1::ascii::String {
        arg0.website_url
    }

    public fun new(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: vector<0x1::ascii::String>) : DappMetadata {
        DappMetadata{
            name        : arg0,
            description : arg1,
            icon_url    : arg2,
            website_url : arg3,
            created_at  : arg4,
            partners    : arg5,
        }
    }

    public fun set(arg0: &mut DappMetadata, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64, arg6: vector<0x1::ascii::String>) {
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.icon_url = arg3;
        arg0.website_url = arg4;
        arg0.created_at = arg5;
        arg0.partners = arg6;
    }

    public fun set_created_at(arg0: &mut DappMetadata, arg1: u64) {
        arg0.created_at = arg1;
    }

    public fun set_description(arg0: &mut DappMetadata, arg1: 0x1::ascii::String) {
        arg0.description = arg1;
    }

    public fun set_icon_url(arg0: &mut DappMetadata, arg1: 0x1::ascii::String) {
        arg0.icon_url = arg1;
    }

    public fun set_name(arg0: &mut DappMetadata, arg1: 0x1::ascii::String) {
        arg0.name = arg1;
    }

    public fun set_partners(arg0: &mut DappMetadata, arg1: vector<0x1::ascii::String>) {
        arg0.partners = arg1;
    }

    public fun set_website_url(arg0: &mut DappMetadata, arg1: 0x1::ascii::String) {
        arg0.website_url = arg1;
    }

    // decompiled from Move bytecode v6
}

