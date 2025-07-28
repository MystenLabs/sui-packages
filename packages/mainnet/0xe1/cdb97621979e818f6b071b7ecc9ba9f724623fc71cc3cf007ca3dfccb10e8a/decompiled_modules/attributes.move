module 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::attributes {
    struct Attributes has drop, store {
        collection: 0x1::string::String,
        head: 0x1::string::String,
        body: 0x1::string::String,
        background: 0x1::string::String,
        serial_number: u64,
        faction: 0x1::option::Option<0x1::string::String>,
        equipped_hat: 0x1::option::Option<0x1::string::String>,
        equipped_shirt: 0x1::option::Option<0x1::string::String>,
        equipped_pants: 0x1::option::Option<0x1::string::String>,
        equipped_accessory: 0x1::option::Option<0x1::string::String>,
        total_raids: 0x1::option::Option<u64>,
    }

    public fun background(arg0: &Attributes) : &0x1::string::String {
        &arg0.background
    }

    public fun body(arg0: &Attributes) : &0x1::string::String {
        &arg0.body
    }

    public fun clear_equipped_items(arg0: &mut Attributes) {
        arg0.equipped_hat = 0x1::option::none<0x1::string::String>();
        arg0.equipped_shirt = 0x1::option::none<0x1::string::String>();
        arg0.equipped_pants = 0x1::option::none<0x1::string::String>();
        arg0.equipped_accessory = 0x1::option::none<0x1::string::String>();
    }

    public fun collection(arg0: &Attributes) : &0x1::string::String {
        &arg0.collection
    }

    public fun equipped_accessory(arg0: &Attributes) : &0x1::option::Option<0x1::string::String> {
        &arg0.equipped_accessory
    }

    public fun equipped_hat(arg0: &Attributes) : &0x1::option::Option<0x1::string::String> {
        &arg0.equipped_hat
    }

    public fun equipped_pants(arg0: &Attributes) : &0x1::option::Option<0x1::string::String> {
        &arg0.equipped_pants
    }

    public fun equipped_shirt(arg0: &Attributes) : &0x1::option::Option<0x1::string::String> {
        &arg0.equipped_shirt
    }

    public fun faction(arg0: &Attributes) : &0x1::option::Option<0x1::string::String> {
        &arg0.faction
    }

    public fun has_equipped_items(arg0: &Attributes) : bool {
        if (0x1::option::is_some<0x1::string::String>(&arg0.equipped_hat)) {
            true
        } else if (0x1::option::is_some<0x1::string::String>(&arg0.equipped_shirt)) {
            true
        } else if (0x1::option::is_some<0x1::string::String>(&arg0.equipped_pants)) {
            true
        } else {
            0x1::option::is_some<0x1::string::String>(&arg0.equipped_accessory)
        }
    }

    public fun has_faction(arg0: &Attributes) : bool {
        0x1::option::is_some<0x1::string::String>(&arg0.faction)
    }

    public fun head(arg0: &Attributes) : &0x1::string::String {
        &arg0.head
    }

    public fun new_attributes(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64) : Attributes {
        Attributes{
            collection         : arg0,
            head               : arg1,
            body               : arg2,
            background         : arg3,
            serial_number      : arg4,
            faction            : 0x1::option::none<0x1::string::String>(),
            equipped_hat       : 0x1::option::none<0x1::string::String>(),
            equipped_shirt     : 0x1::option::none<0x1::string::String>(),
            equipped_pants     : 0x1::option::none<0x1::string::String>(),
            equipped_accessory : 0x1::option::none<0x1::string::String>(),
            total_raids        : 0x1::option::none<u64>(),
        }
    }

    public fun serial_number(arg0: &Attributes) : u64 {
        arg0.serial_number
    }

    public fun set_background(arg0: &mut Attributes, arg1: 0x1::string::String) {
        arg0.background = arg1;
    }

    public fun set_body(arg0: &mut Attributes, arg1: 0x1::string::String) {
        arg0.body = arg1;
    }

    public fun set_collection(arg0: &mut Attributes, arg1: 0x1::string::String) {
        arg0.collection = arg1;
    }

    public fun set_equipped_accessory(arg0: &mut Attributes, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.equipped_accessory = arg1;
    }

    public fun set_equipped_hat(arg0: &mut Attributes, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.equipped_hat = arg1;
    }

    public fun set_equipped_pants(arg0: &mut Attributes, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.equipped_pants = arg1;
    }

    public fun set_equipped_shirt(arg0: &mut Attributes, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.equipped_shirt = arg1;
    }

    public fun set_faction(arg0: &mut Attributes, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.faction = arg1;
    }

    public fun set_head(arg0: &mut Attributes, arg1: 0x1::string::String) {
        arg0.head = arg1;
    }

    public fun set_serial_number(arg0: &mut Attributes, arg1: u64) {
        arg0.serial_number = arg1;
    }

    public fun set_total_raids(arg0: &mut Attributes, arg1: u64) {
        if (arg1 > 0) {
            arg0.total_raids = 0x1::option::some<u64>(arg1);
        } else {
            arg0.total_raids = 0x1::option::none<u64>();
        };
    }

    public fun total_raids(arg0: &Attributes) : &0x1::option::Option<u64> {
        &arg0.total_raids
    }

    // decompiled from Move bytecode v6
}

