module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node {
    struct Node has key {
        id: 0x2::object::UID,
        authority: address,
        owner: address,
        queue_addr: address,
        last_heartbeat: u64,
        version: u64,
    }

    public(friend) fun new(arg0: address, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Node {
        Node{
            id             : 0x2::object::new(arg3),
            authority      : arg0,
            owner          : arg1,
            queue_addr     : arg2,
            last_heartbeat : 0,
            version        : 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(),
        }
    }

    public fun authority(arg0: &Node) : address {
        arg0.authority
    }

    public fun has_authority(arg0: &Node, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.authority == 0x2::tx_context::sender(arg1)
    }

    public fun last_heartbeat(arg0: &Node) : u64 {
        arg0.last_heartbeat
    }

    entry fun migrate(arg0: &mut Node, arg1: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::AdminCap) {
        assert!(arg0.version < 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        arg0.version = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version();
    }

    public fun node_address(arg0: &Node) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun owner(arg0: &Node) : address {
        arg0.owner
    }

    public fun queue_addr(arg0: &Node) : address {
        arg0.queue_addr
    }

    public(friend) fun set_last_heartbeat(arg0: &mut Node, arg1: u64) {
        assert!(arg0.version == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.last_heartbeat = arg1;
    }

    public fun share_node(arg0: Node) {
        0x2::transfer::share_object<Node>(arg0);
    }

    // decompiled from Move bytecode v6
}

